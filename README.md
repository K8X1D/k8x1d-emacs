# K8x1d Emacs configuration


## To use
The bash script named `bin/k8x1d-emacs` manage most of the interactions with emacs (adding it to `$PATH` hence facilitates management).

To install, simply launch :

``` bash
/path/to/project/bin/k8x1d-emacs -i 
```

The installation location is separated from the rest of the system to limit pollution of the user environment. The variables `GUIX_EXTRA` and `GUIX_EXTRA_PROFILES` can be modified in `bin/k8x1d-emacs` to adjust to location of both the channel pin guix and emacs installation.  

Once installation is done, k8x1d-emacs can be launch via 
``` bash
/path/to/project/bin/k8x1d-emacs
```



