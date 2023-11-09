local status_ok, icons = pcall(require, "nvim-web-devicons")
if not status_ok then
  return
end

icons.set_icon {
  Dockerfile = {
    icon = "",
    color = "#61AFEF",
    cterm_color = "4",
    name = "Dockerfile"
  }
}
icons.set_icon {
  tf = {
    icon = "",
    color = "#5F43E9",
    cterm_color = "93",
    name = "Terraform"
  }
}
