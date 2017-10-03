local logLevels = {	off = 0, fatal = 100, error = 200, warning = 300, info = 400, debug = 500, trace = 600, all = 999,
					[0] = 'off', [100] = 'fatal', [200] = 'error', [300] = 'warning', [400] = 'info', [500] = 'debug', [600] = 'trace', [999] = 'all'}
return logLevels
