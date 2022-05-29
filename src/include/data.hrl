-record(event,
        {evt_id = 0,
         evt_key = any,
         evt_time = erlang:system_time(),
         usr_id = 0,
         usr_name = "",
         usr_mobile = ""}).
-record(event_view,
        {gid = 0,
         evt_id = 0,
         evt_key = any,
         evt_time = erlang:system_time(),
         usr_id = 0,
         usr_name = "",
         usr_mobile = ""}).

-define(REPORT_FILE, "/tmp/reports/report").
