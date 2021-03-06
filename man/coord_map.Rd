% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/coord-map.r
\name{coord_map}
\alias{coord_map}
\title{Map projections.}
\usage{
coord_map(projection = "mercator", ..., orientation = NULL, xlim = NULL,
  ylim = NULL)
}
\arguments{
\item{projection}{projection to use, see
\code{\link[mapproj]{mapproject}} for list}

\item{...}{other arguments passed on to
\code{\link[mapproj]{mapproject}}}

\item{orientation}{projection orientation, which defaults to
\code{c(90, 0, mean(range(x)))}.  This is not optimal for many
projections, so you will have to supply your own. See
\code{\link[mapproj]{mapproject}} for more information.}

\item{xlim}{manually specific x limits (in degrees of lontitude)}

\item{ylim}{manually specific y limits (in degrees of latitude)}
}
\description{
This coordinate system provides the full range of map projections available
in the mapproj package.
}
\details{
This is still experimental, and if you have any advice to offer regarding
a better (or more correct) way to do this, please let me know
}
\examples{
if (require("maps")) {
# Create a lat-long dataframe from the maps package
nz <- map_data("nz")
nzmap <- ggplot(nz, aes(x=long, y=lat, group=group)) +
  geom_polygon(fill="white", colour="black")

# Use cartesian coordinates
nzmap
# With default mercator projection
nzmap + coord_map()
# Other projections
nzmap + coord_map("cylindrical")
nzmap + coord_map("azequalarea",orientation=c(-36.92,174.6,0))

states <- map_data("state")
usamap <- ggplot(states, aes(x=long, y=lat, group=group)) +
  geom_polygon(fill="white", colour="black")

# Use cartesian coordinates
usamap
# With mercator projection
usamap + coord_map()
# See ?mapproject for coordinate systems and their parameters
usamap + coord_map("gilbert")
usamap + coord_map("lagrange")

# For most projections, you'll need to set the orientation yourself
# as the automatic selection done by mapproject is not available to
# ggplot
usamap + coord_map("orthographic")
usamap + coord_map("stereographic")
usamap + coord_map("conic", lat0 = 30)
usamap + coord_map("bonne", lat0 = 50)

# World map, using geom_path instead of geom_polygon
world <- map_data("world")
worldmap <- ggplot(world, aes(x=long, y=lat, group=group)) +
  geom_path() +
  scale_y_continuous(breaks=(-2:2) * 30) +
  scale_x_continuous(breaks=(-4:4) * 45)

# Orthographic projection with default orientation (looking down at North pole)
worldmap + coord_map("ortho")
# Looking up up at South Pole
worldmap + coord_map("ortho", orientation=c(-90, 0, 0))
# Centered on New York (currently has issues with closing polygons)
worldmap + coord_map("ortho", orientation=c(41, -74, 0))
}
}

