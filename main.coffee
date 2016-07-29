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
    console.log "[POLICY][BACKUP]", "Initialized backup of #{@orig} into #{@dest}"

  receiver : (changes) =>
    # Read watched file and pipe contents into backup
    fs.createReadStream(@orig).pipe fs.createWriteStream @dest

module.exports = Copier
