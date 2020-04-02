### Internal function to obtain a response from a POST call
brapi_POST <- function(url, body, usedArgs) {
  brapi_message(msg = paste0("URL call was: ", url, "\n"))
  brapi_message(msg = paste0("Waiting for response from server: ...\n"))

  resp <- httr::POST(url = url,
                     body = body,
                     encode = "json",
                     httr::timeout(25),
                     httr::add_headers("Authorization" = paste("Bearer", usedArgs[["con"]][["token"]])))

  txt <- ifelse(resp$status == 200, " ok!", " problem!")
  brapi_message(msg = paste0("Server status: ", txt, "\n"))
  # url <- httr::content(resp)
  # if (format == "json") show_server_status_messages(resp)
  return(resp)
}
