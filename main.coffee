'use strict'
path = require 'path'
fs = require 'fs'
mkdirp = require 'mkdirp'

class Backup
  constructor : (params) ->
    @prev = params.version is 'prev'
    @timed = params.naming is 'timed'
    @folder = path.resolve params.copyTo
    @filename = path.basename params.path
    # Calculate destination file path
    @dest = "#{@folder}/#{@filename}.bak"
    # Make sure destination folder exists
    try
      fs.accessSync @dest, fs.F_OK
    catch e
      mkdirp params.copyTo, =>
       console.log "Initialized backup of #{@filename} into #{@folder}"

  receiver : ({prev, cur}) =>
    state = cur
    if @prev
      state = prev
    # Update file name if backup naming is "timed"
    if @timed
      @dest = "#{@folder}/#{@filename}@#{state.time}.bak"
    # Write backup
    fs.writeFile @dest, state.content, 'utf8'

module.exports = Backup
