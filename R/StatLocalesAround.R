#' @export
compute_panel_around <- function(data, scales, around_start = 0, radius = 1, x0 = 0, y0 = 0){
  
  data |> 
    mutate(row_id = dplyr::row_number()) |> 
    mutate(around = - 2 * pi * row_id/dplyr::n() - around_start * 2*pi / 360,
           x = radius*cos(around) + x0, 
           y = radius*sin(around) + y0,
           angle = 360*around/(2*pi),
           x0 = x0,
           y0 = y0
           )

}

#' @export
StatAround <- ggplot2::ggproto("StatAround", ggplot2::Stat, 
                      compute_panel = compute_panel_around,
                      default_aes = ggplot2::aes(hjust = ggplot2::after_stat(1), 
                                        xend = ggplot2::after_stat(x0),
                                        yend = ggplot2::after_stat(y0)))


a_day <- tibble::tibble(hour = 1:24, 
       hour_pretty = rep(1:12, 2) |> 
         paste(c(rep("AM", 11), "noon",
               c(rep("PM", 11), "midnight"))) |>
         stringr::str_remove("12 "))

#' @export
compute_panel_locales_around <- function(data, scales, around_start = 0, radius = 1, x0 = 0, y0 = 0, 
                                         from_date_time = Sys.Date() |> paste("09:00:00"), from_tz = Sys.timezone()){
  
  date_time_tz_to_tzs(
    from_date_time = from_date_time, 
    from_tz = from_tz, 
    to_tz = data$tz) |>
  local_tzs_df_collapse() |> 
  dplyr::mutate(hour = local_time_hm |> 
           stringr::str_extract("\\d+") |> 
           as.numeric())  |>
  dplyr::right_join(a_day, by = "hour") |> 
  dplyr::arrange(hour) |> 
  compute_panel_around(scales = scales, 
                       around_start = around_start, 
                       radius = radius, 
                       x0 = x0, 
                       y0 = y0) |>
  dplyr::filter_out(is.na(locations)) |> 
  dplyr::mutate(PANEL = 1) # not the best, Gina, not the best...

}

#' @export
StatLocalesAround <- ggplot2::ggproto("StatLocalesAround", ggplot2::Stat, 
                      compute_panel = compute_panel_locales_around,
                      default_aes = ggplot2::aes(hjust = ggplot2::after_stat(1), 
                                        label = ggplot2::after_stat(locations),
                                        xend = ggplot2::after_stat(x0),
                                        yend = ggplot2::after_stat(y0)))
