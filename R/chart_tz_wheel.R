#' @export
chart_tz_wheel <- function(
  mapping = ggplot2::aes(), 
  ...,
  .coord = coord_equal_padded(),
  .stamp.polygon.circle = stamp_polygon_circle(),
  .stamp.segment.pie.cuts = stamp_segment_pie_cuts(),
  .stamp.text.hours = stamp_text_hours(),
  .geom.text.places = geom_text_places(mapping = mapping, ...), 
  .theme = theme_timezone_wheel(),
  .other = NULL
){
  
  list(
  .coord, 
  .stamp.polygon.circle,
  .stamp.segment.pie.cuts,
  .stamp.text.hours,
  .geom.text.places, 
  .theme,
  .other
  )
  
}
