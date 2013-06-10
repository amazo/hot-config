class HotConfig
    constructor: (@files = {})->
        @cnf = {}
        for name, file of @files
            @cnf[name] = require file
    reload: (name) ->
        delete require.cache require.resolve @files[name]
        @cnf[name] = require @files[name]
    get: (name) ->
        @cnf[name]

exports.create = (files) ->
    cnf = new HotConfig files
    getConfig = (name) ->
        cnf.get name
    reload_config_path = '/__reload_config__'
    reloadConfig = (req, res) ->
        if req.path is _path_
            cnf.reload req.query.name
            res.send 200
    {getConfig, reloadConfig, reload_config_path}
