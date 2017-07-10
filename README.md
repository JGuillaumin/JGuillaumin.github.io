
My blog : http://jguillaumin.github.io/

(forked from http://deanattali.com/beautiful-jekyll)


------------------------------------------------------------------------------------------


```bash

git clone https://github.com/JGuillaumin/JGuillaumin.github.io.git
cd JGuillaumin.github.io/

docker build -t jekyll-github .
docker run -it -v "$PWD"/:/src/ -p 4000:4000 jekyll-github
```
Use `Ctrl-C` to stop the container.


Or add this `alias` to `~/.bashrc``:

```bash
alias jekyll = "docker run -it -v "$PWD"/:/src/ -p 4000:4000 jekyll-github"
```

Can be done by :
```bash

echo "alias jekyll='docker run -it -v "$PWD"/:/src/ -p 4000:4000 jekyll-github' " >> ~/.bashrc
source ~/.bashrc
jekyll
```

**Note** : `$PWD` will be replaced by the current working directory. So this alias works only for your blog.



