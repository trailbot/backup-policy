'use strict'
path = require 'path'
fs = require 'fs'

class Copier
  constructor : (params) ->
    @orig = params.path
    @dest = path.resolve params.copyTo
    # Make sure destination path exists
    try
      fs.accessSync @dest, fs.F_OK
    catch e
      fs.writeFile @dest, '', 'utf8'
    console.log "[POLICY][BACKUP]", "Initialized backup of #{@orig} into #{@dest}"

  receiver : (changes) =>
    # Read watched file and pipe contents into backup
    fs.createReadStream(@file).pipe fs.createWriteStream @dest

module.exports = Copier
