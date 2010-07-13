#! /bin/ruby

require File.join(File.dirname(__FILE__), "backtick")

def bps i
  k = 1 << 10
  m = 1 << 20
  g = 1 << 30
  if i == 0 or i.nan?
    "0.0 MiB/s"
  elsif i < 1000
    sprintf "%5.1f B/s", i
  elsif i < 1000 * k
    sprintf "%5.1f KiB/s", i / k
  elsif i < 1000 * m
    sprintf "%5.1f MiB/s", i / m
  else
    sprintf "%5.1f GiB/s", i / g
  end
end

memo = nil
backtick 4 do
  a = [0, 0, Time.now.to_f]
  a[0] += `cat /proc/net/dev | grep eth0 | sed -e 's/^.*eth[0-9]://g' | awk '{print $1}'`.to_i
  a[1] += `cat /proc/net/dev | grep eth0 | sed -e 's/^.*eth[0-9]://g' | awk '{print $9}'`.to_i
  if memo
    t = a[2] - memo[2]
    if a[0] < memo[0] # counter overflow
      a[0] += 1 << 32
      a[1] += 1 << 32
    end
    ein = (a[0] - memo[0]) / t
    eout = (a[1] - memo[1]) / t
  else
    ein = eout = 0
  end
  memo=a
  puts "\c%{=b wR}in: " + bps(ein) +
       "\c%{=b wk} | " +
       "\c%{=b wB}out: " + bps(eout)
end

# from http://coderepos.org/share/browser/dotfiles/screen/shyouhei/.screen/backtick.rb?rev=36314
# modified by joker1007
