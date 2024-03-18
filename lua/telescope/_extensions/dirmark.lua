return require("telescope").register_extension {
  setup = function(ext_config, config) end,
  exports = {
    dirmark = require("dirmark").dirmark
  },
}
