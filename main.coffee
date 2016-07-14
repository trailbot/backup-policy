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
    string = ""
    for change in changes
      if change.type is 'add'
        string += change.lines.join os.EOL
    if string.length > 0
      fs.appendFile @file, "#{string}#{os.EOL}"

module.exports = Copier
