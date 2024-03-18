return require("telescope").register_extension {
  setup = function(ext_config, config) end,
  exports = {
    roam = require("roam").search
  },
}
