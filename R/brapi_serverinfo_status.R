### Internal function to display status serverinfo
### used to be show_server_status_messages
brapi_serverinfo_status <- function(out) {
  show_message <- function(msg_type, msg_Title, msg_color) {
    brapi_message(msg = msg_color(paste0("\n", msg_Title,":")))
    sapply(out[names(out) == msg_type] %>% unlist, msg_color) %>%
      as.character %>%
      paste0("\n") %>%
      brapi_message()
  }

  if (!getOption("brapi_info", default = FALSE)) {
    return()
  }

  # if(!is.null(out$metadata)) {
  #   out <- out$metadata$status %>% unlist %>% as.list()
  #   brapi_message(msg = crayon::yellow("Status details from Server:"))
  #
  #   show_message("info", "Infos", crayon::blue)
  #   show_message("success", "Successes", crayon::green)
  #   show_message("error", "Errors", crayon::red)
  #
  # }
}
