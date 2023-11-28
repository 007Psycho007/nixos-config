return {
    "rest-nvim/rest.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    opts = {
        skip_ssl_verification = false,
        result = {
        show_url = true,
        show_curl_command = false,
        show_headers = true,
        formatters = {
          json = "jq",
          html = function(body)
            return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
          end
        },
      },       
    }
}
