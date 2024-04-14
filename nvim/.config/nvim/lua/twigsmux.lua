local twigsmux = {
    msg = "MEOW"
};

twigsmux.execute = function(kill)
    local Job = require 'plenary.job'

    if (Job == nil) then
        return;
    end

    local dir = string.format("%s/.zsh_scripts", vim.env.HOME);
    local args = string.format("%s/twigsmux.sh", dir);
    if (kill) then
        args = string.format("%s k", args);
    end

    Job:new({
        command = 'bash',
        cwd = '/usr/bin',
        args = { args },
    }):start()
end

twigsmux.switch = function()
    twigsmux.execute(false);
end

twigsmux.kill = function()
    twigsmux.execute(true);
end

return twigsmux;
