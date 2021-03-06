% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/findNLDI.R
\name{findNLDI}
\alias{findNLDI}
\title{Retrieve features from the \href{https://labs.waterdata.usgs.gov/api/nldi/swagger-ui/index.html?configUrl=/api/nldi/v3/api-docs/swagger-config}{NLDI}}
\usage{
findNLDI(
  comid = NULL,
  nwis = NULL,
  wqp = NULL,
  huc12 = NULL,
  location = NULL,
  origin = NULL,
  nav = NULL,
  find = NULL,
  distance_km = 100,
  no_sf = FALSE
)
}
\arguments{
\item{comid}{an NHDPlusV2 COMID}

\item{nwis}{a USGS NWIS siteID}

\item{wqp}{a water quality point ID}

\item{huc12}{a HUC12 ID}

\item{location}{Coordinate pair in WGS84 GCS provided as a numeric vector ordered lng/lat}

\item{origin}{a named list specifying a feature type and ID (e.g. list("comid" = 101))}

\item{nav}{where to navigate from the starting point ("UM", "UT", DM", "DD")}

\item{find}{what resources to find along the navigation path(s) (see get_nldi_sources()$source). Can also include 'basin', which will return the upstream basin of the starting feature}

\item{distance_km}{how far to look along the navigation path in kilometers (default = 100)}

\item{no_sf}{if available, should `sf` be used for parsing, defaults to `TRUE` if `sf` is locally installed}
}
\value{
a list of data.frames
}
\description{
Provides a formal query to the
\href{https://labs.waterdata.usgs.gov/about-nldi/index.html}{Network Linked Data Index}.
The function is useful for topology and location based feature discovery.
A user must supply a starting feature, and can add optional navigation direction(s),
and features to identify on the navigated network.
Valid starting options can be given by one of the following arguments: comid, nwis, huc12,
 wqp, location, and start.
}
\examples{

# Find Features / Define origin features

## Find feature by COMID
 findNLDI(comid = 101)

## Find feature by NWIS ID
 findNLDI(nwis = '11120000')

## Find feature by WQP ID
 findNLDI(wqp = 'USGS-04024315')

## Find feature by LOCATION
 findNLDI(location = c(-115,40))

## GENERAL ORIGIN: COMID
 findNLDI(origin = list("comid" = 101))

## GENERAL ORIGIN: WaDE
 findNLDI(origin = list("wade" = 'CA_45206'))

# Navigation
# UPPER MAINSTEM of USGS-11120000
 str(findNLDI(nwis = '11120000', nav = "UM"), max.level = 1)

# MULTI-REQUEST
# UPPER MAINSTEM and TRIBUTARY of USGS-11120000
 str(findNLDI(nwis = '11120000', nav = c("UT", "UM")), max.level = 1)

# Discover Features

## Find feature(s) on the upper tributary of USGS-11120000
 str(findNLDI(nwis = '11120000', nav = "UT", find = c("nwis", "wqp")), max.level = 1)

## Find upstream basin boundary of USGS-11120000
 str(findNLDI(nwis = '11120000',  find = "basin"), max.level = 1)

# Control Distance

## Limit search to 100 km
 str(findNLDI(comid = 101, nav = "DM", find = c("nwis", "wqp"), distance_km = 100), max.level = 1)

## Convert returned list of data.frames to list of spatial features
\donttest{
 nldi = findNLDI(nwis = '11120000', nav = "UT", find = c("nwis", "wqp"))
 str(nldi, max.level = 1)
 }
}
\keyword{nldi}
