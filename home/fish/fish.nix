{
  config,
  options,
  lib,
  pkgs,
  ...
}: 

{
    programs.eza = {
      enable = true;
      colors = "always";


    };
    programs.fish = {
        enable = true;
        generateCompletions = true;
            
        shellAliases = {
            ls = "eza";

        };
        
        interactiveShellInit = ''
            set EDITOR nvim
            set -g fish_greeting
            powerline-setup

            set -g fish_key_bindings fish_vi_key_bindings
            function update_cwd_osc --on-variable PWD --description 'Notify terminals when $PWD changes'
                if status --is-command-substitution || set -q INSIDE_EMACS
                    return
                end
                printf \e\]7\;file://%s%s\e\\ $hostname (string escape --style=url $PWD)
            end

            update_cwd_osc

        ''
}
