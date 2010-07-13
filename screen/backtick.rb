#! /bin/ruby

def attribute c, s
	ss = s.to_s
	if ss.empty?
		ss
	else
		["\c%{=", c, '}', ss, "\c%{= dd}"].join('')
	end
end

def colorf t, f, r = ''
	c = if f < 0.6
			 "#{r} db"
		 elsif f < 0.7
			 "#{r} dy"
		 elsif f < 0.8
			 "#{r} dY"
		 elsif f < 0.9
			 "#{r} dr"
		 else
			 "#{r} dw"
		 end
	attribute c, t
end

def bar_minmax cur, min, max, title = cur.to_s, width = 32
	f = (cur - min) / (max - min)
	x = ' ' * (f * width)
	y = ' ' * (width - x.length)
	sprintf "%s[%s%s]", colorf(title, f), colorf(x, f, 'r'), y
end

def bar2 f, g, n = 32
	x = ' ' * (f * n)
	y = ' ' * (g * n)
	z = ' ' * (n - x.length - y.length)
	sprintf("%3d%%+%3d%%[%s%s%s]",
			  (f * 100).round,
			  (g * 100).round,
			  attribute(' rd', x),
			  attribute(' wd', y),
			  z)
end

def bar f, n = 32
	t = sprintf "%3%%", (f * 100).round
	bar_minmax f, 0.0, 1.0, t, n
end

def backtick sec=0
	STDOUT.sync = true
	while true do
		str = yield
		puts str unless str.nil?
		sleep sec
	end
end


# Local Variables:
# mode: ruby
# coding: utf-8
# indent-tabs-mode: t
# tab-width: 3
# ruby-indent-level: 3
# fill-column: 79
# default-justification: full
# End:
# vi: ts=3 sw=3
