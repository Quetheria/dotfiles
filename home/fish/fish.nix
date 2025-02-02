{
  config,
  options,
  lib,
  pkgs,
  ...
}: {
  programs.eza = {
    enable = true;
    colors = "always";
  };

  programs.bat = {
    enable = true;
  };
  programs.fish = {
    enable = true;
    generateCompletions = true;

    shellAliases = {
      ls = "eza";
      cat = "bat";
    };

    interactiveShellInit = ''
      set fish_function_path $fish_function_path "/usr/share/powerline/bindings/fish"
      set EDITOR nvim
      set -g fish_greeting
      set -g fish_key_bindings fish_vi_key_bindings
      function fish_prompt
         string join '\' -- $PWD '>\'
      end

      powerline-setup

      function update_cwd_osc --on-variable PWD --description 'Notify terminals when $PWD changes'
          if status --is-command-substitution || set -q INSIDE_EMACS
              return
          end
          printf \e\]7\;file://%s%s\e\\ $hostname (string escape --style=url $PWD)
      end

      update_cwd_osc

    '';
  };
}
