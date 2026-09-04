#' @export
geom_text_places <- ggplot2::make_constructor(ggplot2::GeomText, stat = StatLocalesAround, radius = .95, hjust = 1)

#' @export
stamp_text_hours <- ggplot2::make_constructor(ggplot2::GeomText, stat = StatAround, radius = 1.025, hjust = 0, inherit.aes = FALSE, data = a_day, mapping = ggplot2::aes(label = hour_pretty))

#' @export
stamp_segment_pie_cuts <- ggplot2::make_constructor(ggplot2::GeomSegment, stat = StatAround, around_start = pi/24 + 1, linetype = "dotted", inherit.aes = FALSE, data = a_day, mapping = ggplot2::aes(label = hour_pretty))

#' @export
GeomPolygonHollow <- ggplot2::ggproto("GeomPolygonHollow", ggplot2::GeomPolygon,
                             default_aes = ggplot2::GeomPolygon$default_aes |> 
                               modifyList(ggplot2::aes(color = ggplot2::from_theme(ink), fill = NA)))

#' @export
stamp_polygon_circle <- ggplot2::make_constructor(GeomPolygonHollow, 
                                         stat = StatAround, 
                                         data = data.frame(x = 1:200), 
                                         inherit.aes = FALSE)

#' @export
theme_timezone_wheel <- function(base_size = 9, ink = "grey20", paper = "white", ...){
  
  theme_void(base_size = base_size, ink = ink, paper = paper,  ...)
  
}

#' @export
coord_equal_padded <- function(...){coord_equal(ylim = c(-1.2,1.2), 
                                                xlim = c(-1.2,1.2), ...)}
