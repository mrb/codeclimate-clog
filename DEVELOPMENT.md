http://blog.codeclimate.com/blog/2015/07/07/build-your-own-codeclimate-engine/

# Testing locally

Build docker container
```
docker build --rm -t masone/codeclimate-clog .
```

Enable engine in .codeclimate.yml
```
engines:
  clog:
    enabled: true
```

Run engine
```
codeclimate analyze --dev
```

