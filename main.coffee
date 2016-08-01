'use strict'
path = require 'path'
fs = require 'fs'

class Copier
  constructor : (params) ->
    @orig = path.resolve params.path
    @filename = path.basename @orig
    # Calculate destination file path
    @dest = path.resolve "#{params.copyTo}/#{@filename}"
    # Make sure destination path exists
    try
      fs.accessSync @dest, fs.F_OK
    catch e
      fs.writeFile @dest, '', 'utf8'
    console.log "Initialized backup of #{@orig} into #{@dest}"

  receiver : (changes, {prev, cur}) =>
    # Read watched file and pipe contents into backup
    fs.createWriteFile @dest, cur, 'utf8'

module.exports = Copier
