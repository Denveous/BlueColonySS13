#define SECOND *10
#define SECONDS *10

#define MINUTE *600
#define MINUTES *600

#define HOUR *36000
#define HOURS *36000

#define DAY *864000
#define DAYS *864000

#define TimeOfGame (get_game_time())
#define TimeOfTick (TICK_USAGE*0.01*world.tick_lag)

#define TICK *world.tick_lag
#define TICKS *world.tick_lag

#define DS2TICKS(DS) (DS/world.tick_lag)	// Convert deciseconds to ticks
#define TICKS2DS(T) ((T) TICKS) 				// Convert ticks to deciseconds

/proc/get_game_time()
	var/global/time_offset = 0
	var/global/last_time = 0
	var/global/last_usage = 0

	var/wtime = world.time
	var/wusage = TICK_USAGE * 0.01

	if(last_time < wtime && last_usage > 1)
		time_offset += last_usage - 1

	last_time = wtime
	last_usage = wusage

	return wtime + (time_offset + wusage) * world.tick_lag

var/roundstart_hour
var/station_date = ""
var/next_station_date_change = 1 DAY

#define duration2stationtime(time) time2text(station_time_in_ticks + time, "hh:mm")
#define worldtime2stationtime(time) time2text(get_game_hour() HOURS + time, "hh:mm")
#define round_duration_in_ticks (round_start_time ? world.time - round_start_time : 0)
#define station_time_in_ticks (get_game_hour() HOURS + round_duration_in_ticks)

/proc/stationtime2text()
	return time2text(station_time_in_ticks, "hh:mm")

/proc/stationdate2text()
	var/update_time = FALSE
	if(station_time_in_ticks > next_station_date_change)
		next_station_date_change += 1 DAY
		update_time = TRUE
	if(!station_date || update_time)
		var/extra_days = round(station_time_in_ticks / (1 DAY)) DAYS
		var/timeofday = world.timeofday + extra_days
		station_date = num2text((text2num(time2text(timeofday, "YYYY"))+config.years_in_future)) + "-" + time2text(timeofday, "MM-DD")
	return station_date

/proc/get_game_year()
	var/game_year = (time2text(world.timeofday, "YYYY"))
	game_year = (text2num(game_year)) + config.years_in_future
	return game_year

/proc/get_game_month()
	var/game_month = (time2text(world.timeofday, "MM"))
	game_month = (text2num(game_month)) + config.months_in_future
	return game_month

/proc/get_game_day()
	var/game_day = (time2text(world.timeofday, "DD"))
	game_day = (text2num(game_day)) + config.days_in_future
	return game_day

/proc/get_game_hour()
	var/game_hour = (time2text(world.timeofday, "hh"))
	game_hour = (text2num(game_hour))
	return game_hour

/proc/get_game_minute()
	var/game_minute = (time2text(world.timeofday, "mm"))
	game_minute = (text2num(game_minute))
	return game_minute

/proc/get_game_second()
	var/game_second = (time2text(world.timeofday, "ss"))
	game_second = (text2num(game_second))
	return game_second

/proc/get_real_year()
	var/year = (time2text(world.timeofday, "YYYY"))
	year = (text2num(year))
	return year

/proc/get_real_month()
	var/month = (time2text(world.timeofday, "MM"))
	month = (text2num(month))
	return month

/proc/get_real_day()
	var/day = (time2text(world.timeofday, "DD"))
	day = (text2num(day))
	return day

/proc/full_game_time()
	return "[get_game_day()]/[get_game_month()]/[get_game_year()]"

/proc/full_real_time()
	return "[get_real_day()]/[get_real_month()]/[get_real_year()]"

//ISO 8601
/proc/time_stamp()
	var/date_portion = time2text(world.timeofday, "YYYY-MM-DD")
	var/time_portion = time2text(world.timeofday, "hh:mm:ss")
	return "[date_portion]T[time_portion]"

/* Returns 1 if it is the selected month and day */
proc/isDay(var/month, var/day)
	if(isnum(month) && isnum(day))
		var/MM = text2num(time2text(world.timeofday, "MM")) // get the current month
		var/DD = text2num(time2text(world.timeofday, "DD")) // get the current day
		if(month == MM && day == DD)
			return 1

		// Uncomment this out when debugging!
		//else
			//return 1

var/next_duration_update = 0
var/last_round_duration = 0
var/round_start_time = 0

/hook/roundstart/proc/start_timer()
	round_start_time = world.time
	return 1

/proc/roundduration2text()
	if(!round_start_time)
		return "00:00"
	if(last_round_duration && world.time < next_duration_update)
		return last_round_duration

	var/mills = round_duration_in_ticks // 1/10 of a second, not real milliseconds but whatever
	//var/secs = ((mills % 36000) % 600) / 10 //Not really needed, but I'll leave it here for refrence.. or something
	var/mins = round((mills % 36000) / 600)
	var/hours = round(mills / 36000)

	mins = mins < 10 ? add_zero(mins, 1) : mins
	hours = hours < 10 ? add_zero(hours, 1) : hours

	last_round_duration = "[hours]:[mins]"
	next_duration_update = world.time + 1 MINUTES
	return last_round_duration

//Can be useful for things dependent on process timing
proc/process_schedule_interval(var/process_name)
	var/datum/controller/process/process = processScheduler.getProcess(process_name)
	return process.schedule_interval

/hook/startup/proc/set_roundstart_hour()
	roundstart_hour = get_game_hour()
	return 1

/var/midnight_rollovers = 0
/var/rollovercheck_last_timeofday = 0
/proc/update_midnight_rollover()
	if (world.timeofday < rollovercheck_last_timeofday) //TIME IS GOING BACKWARDS!
		return midnight_rollovers++
	return midnight_rollovers

//Increases delay as the server gets more overloaded,
//as sleeps aren't cheap and sleeping only to wake up and sleep again is wasteful
#define DELTA_CALC max(((max(TICK_USAGE, world.cpu) / 100) * max(Master.sleep_delta-1,1)), 1)

//returns the number of ticks slept
/proc/stoplag(initial_delay)
	if (!Master || !(Master.current_runlevel & RUNLEVELS_DEFAULT))
		sleep(world.tick_lag)
		return 1
	if (!initial_delay)
		initial_delay = world.tick_lag
	. = 0
	var/i = DS2TICKS(initial_delay)
	do
		. += CEILING(i*DELTA_CALC, 1)
		sleep(i*world.tick_lag*DELTA_CALC)
		i *= 2
	while (TICK_USAGE > min(TICK_LIMIT_TO_RUN, GLOB.CURRENT_TICKLIMIT))

#undef DELTA_CALC

/proc/start_watch()
	return TimeOfGame

/**
 * Returns number of seconds elapsed.
 * @param wh number The "Watch Handle" from start_watch(). (timestamp)
 */
/proc/stop_watch(wh)
	return round(0.1 * (TimeOfGame - wh), 0.1)