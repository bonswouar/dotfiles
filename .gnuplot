
# Basic configs
#set grid
set grid lc rgb "#737994"
set isosamples 50
set hidden3d

# Draw a background
set object rectangle from screen 0,0 to screen 1,1 behind fillcolor rgb '#414559' fillstyle solid noborder

# Color some lines
set linetype 1 lw 2 lc rgb '#8caaee' pointtype 6
set linetype 2 lw 2 lc rgb '#e78284' pointtype 6
set linetype 3 lw 1 lc rgb '#737994' pointtype 6
set linetype 4 lw 1 lc rgb '#303446' pointtype 6

# Key and border colors
set border lc rgb "#838ba7"
set key textcolor rgb '#c6d0f5'
set xlabel textcolor rgb '#a5adce'
set ylabel textcolor rgb '#b5bfe2'
set xtics nomirror tc rgb "#a5adce"
set ytics nomirror tc rgb "#b5bfe2"
