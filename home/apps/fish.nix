{
  config,
  pkgs,
  flakePath,
  ...
}: let
  symlink = fileName: {recursive ? false}: {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/${fileName}";
    inherit recursive;
  };
in {
  programs = {
    bat = let
      themepkg = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "bat";
        rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
        sha256 = "sha256-6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
      };
    in {
      enable = true;
      config.theme = "Catppuccin-mocha";
      themes = let
        getTheme = flavour:
          builtins.readFile (
            themepkg + "/Catppuccin-${flavour}.tmTheme"
          );
      in {
        Catppuccin-latte = getTheme "latte";
        Catppuccin-frappe = getTheme "frappe";
        Catppuccin-macchiato = getTheme "macchiato";
        Catppuccin-mocha = getTheme "mocha";
      };
    };
    mcfly = {
      enable = false;
      fuzzySearchFactor = 3;
      keyScheme = "vim";
    };
    btop = {
      enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
      };
    };
    lsd = {
      enable = true;
      enableAliases = true;
      settings = {
        no-symlink = false;
      };
    };
    tealdeer = {
      enable = true;
      settings = {
        style = {
          description.foreground = "white";
          command_name.foreground = "green";
          example_text.foreground = "blue";
          example_code.foreground = "white";
          example_variable.foreground = "yellow";
        };
        updates.auto_update = true;
      };
    };
    fzf = {
      enable = true;
      colors = {
        "bg+" = "#040404";
        "fg+" = "#cdd6f4";
        "hl+" = "#f38ba8";
        border = "#74c7ec";
        fg = "#cdd6f4";
        header = "#f38ba8";
        hl = "#f38ba8";
        info = "#cba6f7";
        marker = "#f5e0dc";
        pointer = "#f5e0dc";
        prompt = "#cba6f7";
        spinner = "#f5e0dc";
      };
      defaultOptions = [
        "--height 40%"
        "--reverse"
      ];
    };

    nix-index.enable = true;
    starship.enable = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    fish = {
      enable = true;
      shellAbbrs = {
        # Git
        ga = "git add";
        gb = "git branch";
        gc = "git commit";
        gca = "git commit --amend";
        gcan = "git commit --amend --no-edit";
        gcm = "git checkout main";
        gco = "git checkout";
        gcb = "git checkout -b";
        gd = "git diff";
        gl = "git pull";
        gp = "git push";
        gr = "git rebase";
        gri = "git rebase -i";
        gra = "git rebase --abort";
        grc = "git rebase --continue";
        gs = "git switch";
        gst = "git status";

        # Kubectl

        # TODO: Migrate these to fish functions
        # Execute a kubectl command against all namespaces
        # alias kca='_kca(){ kubectl "$@" --all-namespaces;  unset -f _kca; }; _kca'
        # kres(){;
        #   kubectl set env $@ REFRESHED_AT=$(date +%Y%m%d%H%M%S)
        # }

        # This command is used a LOT both below and in daily life
        k = "kubectl";
        # Apply a YML file
        kaf = "kubectl apply -f";
        # Drop into an interactive terminal on a container
        keti = "kubectl exec -t -i";
        # Manage configuration quickly to switch contexts between local, dev ad staging.
        kcuc = "kubectl config use-context";
        kcsc = "kubectl config set-context";
        kcdc = "kubectl config delete-context";
        kccc = "kubectl config current-context";
        # List all contexts
        kcgc = "kubectl config get-contexts";
        # General aliases
        kdel = "kubectl delete";
        kdelf = "kubectl delete -f";
        # Pod management.
        kgp = "kubectl get pods";
        kgpa = "kubectl get pods --all-namespaces";
        kgpw = "kubectl get pods --watch";
        kgpwide = "kubectl get pods -o wide";
        kep = "kubectl edit pods";
        kdp = "kubectl describe pods";
        kdelp = "kubectl delete pods";
        kgpall = "kubectl get pods --all-namespaces -o wide";
        # get pod by label: kgpl "app=myapp" -n myns
        kgpl = "kubectl get pods -l";
        # get pod by namespace: kgpn kube-system"
        kgpn = "kubectl get pods -n";
        # Service management.
        kgs = "kubectl get svc";
        kgsa = "kubectl get svc --all-namespaces";
        kgsw = "kubectl get svc --watch";
        kgswide = "kubectl get svc -o wide";
        kes = "kubectl edit svc";
        kds = "kubectl describe svc";
        kdels = "kubectl delete svc";
        # Ingress management
        kgi = "kubectl get ingress";
        kgia = "kubectl get ingress --all-namespaces";
        kei = "kubectl edit ingress";
        kdi = "kubectl describe ingress";
        kdeli = "kubectl delete ingress";
        # Namespace management
        kgns = "kubectl get namespaces";
        kens = "kubectl edit namespace";
        kdns = "kubectl describe namespace";
        kdelns = "kubectl delete namespace";
        kcn = "kubectl config set-context --current --namespace";
        kns = "kubens";
        # ConfigMap management
        kgcm = "kubectl get configmaps";
        kgcma = "kubectl get configmaps --all-namespaces";
        kecm = "kubectl edit configmap";
        kdcm = "kubectl describe configmap";
        kdelcm = "kubectl delete configmap";
        # Secret management
        kgsec = "kubectl get secret";
        kgseca = "kubectl get secret --all-namespaces";
        kdsec = "kubectl describe secret";
        kdelsec = "kubectl delete secret";
        # Deployment management.
        kgd = "kubectl get deployment";
        kgda = "kubectl get deployment --all-namespaces";
        kgdw = "kubectl get deployment --watch";
        kgdwide = "kubectl get deployment -o wide";
        ked = "kubectl edit deployment";
        kdd = "kubectl describe deployment";
        kdeld = "kubectl delete deployment";
        ksd = "kubectl scale deployment";
        krsd = "kubectl rollout status deployment";
        # Rollout management.
        kgrs = "kubectl get replicaset";
        kdrs = "kubectl describe replicaset";
        kers = "kubectl edit replicaset";
        krh = "kubectl rollout history";
        kru = "kubectl rollout undo";
        # Statefulset management.
        kgss = "kubectl get statefulset";
        kgssa = "kubectl get statefulset --all-namespaces";
        kgssw = "kubectl get statefulset --watch";
        kgsswide = "kubectl get statefulset -o wide";
        kess = "kubectl edit statefulset";
        kdss = "kubectl describe statefulset";
        kdelss = "kubectl delete statefulset";
        ksss = "kubectl scale statefulset";
        krsss = "kubectl rollout status statefulset";
        # Port forwarding
        kpf = "kubectl port-forward";
        # Tools for accessing all information
        kga = "kubectl get all";
        kgaa = "kubectl get all --all-namespaces";
        # Logs
        kl = "kubectl logs";
        kl1h = "kubectl logs --since 1h";
        kl1m = "kubectl logs --since 1m";
        kl1s = "kubectl logs --since 1s";
        klf = "kubectl logs -f";
        klf1h = "kubectl logs --since 1h -f";
        klf1m = "kubectl logs --since 1m -f";
        klf1s = "kubectl logs --since 1s -f";
        # File copy
        kcp = "kubectl cp";
        # Node Management
        kgno = "kubectl get nodes";
        keno = "kubectl edit node";
        kdno = "kubectl describe node";
        kdelno = "kubectl delete node";
        # PVC management.
        kgpvc = "kubectl get pvc";
        kgpvca = "kubectl get pvc --all-namespaces";
        kgpvcw = "kubectl get pvc --watch";
        kepvc = "kubectl edit pvc";
        kdpvc = "kubectl describe pvc";
        kdelpvc = "kubectl delete pvc";
        # Service account management.
        kdsa = "kubectl describe sa";
        kdelsa = "kubectl delete sa";
        # DaemonSet management.
        kgds = "kubectl get daemonset";
        kgdsw = "kubectl get daemonset --watch";
        keds = "kubectl edit daemonset";
        kdds = "kubectl describe daemonset";
        kdelds = "kubectl delete daemonset";
        # CronJob management.
        kgcj = "kubectl get cronjob";
        kecj = "kubectl edit cronjob";
        kdcj = "kubectl describe cronjob";
        kdelcj = "kubectl delete cronjob";
        # Job management.
        kgj = "kubectl get job";
        kej = "kubectl edit job";
        kdj = "kubectl describe job";
        kdelj = "kubectl delete job";
      };

      interactiveShellInit = ''
        set fish_greeting

        # set vi bindings
        fish_vi_key_bindings

        # set vi cursor
        # wezterm isn't supported out of the box, but we can safely force-enable it.
        set fish_vi_force_cursor 1
        fish_vi_cursor

        # cursor modes
        set fish_cursor_default block
        set fish_cursor_insert line
        set fish_cursor_replace_one underscore
        set fish_cursor_visual block

        function pythonEnv --description 'start a nix-shell with the given python packages' --argument pythonVersion
          if set -q argv[2]
            set argv $argv[2..-1]
          end

          for el in $argv
            set ppkgs $ppkgs "python"$pythonVersion"Packages.$el"
          end

          nix-shell -p $ppkgs
        end


        bind -s --user -M insert \e "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f repaint-mode; end"
        # bind -s --user -M insert \t accept-autosuggestion

        yes | fish_config theme save "Catppuccin Mocha"
      '';

      plugins = [
        # Use the PR Version for now
        {
          name = "fzf.fish";
          src = pkgs.fetchFromGitHub {
            owner = "oddlama";
            repo = "fzf.fish";
            rev = "6331eedaf680323dd5a2e2f7fba37a1bc89d6564";
            sha256 = "sha256-BO+KFvHdbBz7SRA6EuOk2dEC8zORsCH9V04dHhJ6gxw=";
          };
        }
      ];
    };
  };

  xdg.configFile = {
    "starship.toml" = symlink "home/apps/starship/config.toml" {};
    "fish/functions" = symlink "home/apps/fish/functions" {recursive = true;};
    "fish/themes/Catppuccin Mocha.theme".text = builtins.readFile (pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/fish/main/themes/Catppuccin%20Mocha.theme";
      sha256 = "sha256-MlI9Bg4z6uGWnuKQcZoSxPEsat9vfi5O1NkeYFaEb2I=";
    });
  };
  xdg.dataFile = {
    "scripts" = symlink "home/apps/scripts" {recursive = true;};
  };
}
