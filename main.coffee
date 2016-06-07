'use strict'

path = require 'path'
fs = require 'fs'
os = require 'os'

class Copier
  constructor : (params) ->
    @file = path.resolve params.copyTo
    try
      fs.accessSync(@file, fs.F_OK)
    catch e
      fs.writeFile @file, '', 'utf8'
    console.log "Started Copier!"

  receiver : (changes) =>
    console.log 'Processing changes', changes
    fs.appendFile @file, "#{JSON.stringify(changes)}#{os.EOL}"

module.exports = Copier
