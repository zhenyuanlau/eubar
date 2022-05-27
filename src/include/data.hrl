-record(event, {id, user_id, name, time, device}).
-record(user, {id, name, wechat, mobile}).

-define(REPORT_FILE, "/tmp/reports/report").
