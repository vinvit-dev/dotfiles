local severities = {
  ERROR = vim.diagnostic.severity.ERROR,
  WARNING = vim.diagnostic.severity.WARN,
}

local bin = 'phpcs'

return {
  cmd = '/Users/vinvit/.composer/vendor/bin/phpcs',
  stdin = true,
  args = {
    '-q',
    '--report=json',
    function()
      return '--standard=' .. (vim.g.phpcs_standard or 'Drupal')
    end,
    function()
      return '--stdin-path=' .. vim.fn.expand '%:p:.'
    end,
    '-', -- need `-` at the end for stdin support
  },
  ignore_exitcode = true,
  parser = function(output, _)
    if vim.trim(output) == '' or output == nil then
      return {}
    end

    local diagnostics = {}
    local decoded = vim.json.decode(output)
    for _, result in pairs(decoded.files) do
      for _, msg in ipairs(result.messages or {}) do
        table.insert(diagnostics, {
          lnum = msg.line - 1,
          end_lnum = msg.line - 1,
          col = msg.column - 1,
          end_col = msg.column - 1,
          message = msg.message,
          code = msg.source,
          source = bin,
          severity = assert(severities[msg.type], 'missing mapping for severity ' .. msg.type),
        })
      end
    end
    return diagnostics
  end,
}
