# Set terminal to png image
set term png enhanced transparent size 720,480

# Set output filename
set output "p4.png"

# Set table props
set title "Points profile"
set xrange [0:10]
set yrange [0:5]

# Plot
plot "points.txt" pt 7 title 'points', \
     "points.txt" smooth csplines title 'csplines'
