# Copyright (c) 2012-2014 Fabian Affolter <fab@fedoraproject.org>
#
# This software is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
# 
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# 
# Make sure that the xcftools package is available.

cd source
for img in *.xcf; do
    echo "			<img scr=\"img/${img%\.*}.png\" alt=\"\" width=\"1280\" height=\"960\" />"
    xcf2png $img -o ../img/${img%\.*}.png
done
