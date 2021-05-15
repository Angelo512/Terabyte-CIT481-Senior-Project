
### Team Blog on Github Pages!
[Terabyte Team Blog](https://angelo512.github.io/Terabyte-CIT481-Senior-Project/) 

### How to create Hugo page on Github
- Install Hugo
I use `Choclolatey` to install Hugo for MacOS it can use `Homebrew` to install
```
$ choco install hugo  
```
for MacOS
```
$ brew install hugo
```

- Create a new site  
Create a mew Hugo site in a folder
```
$ hugo new site [foldername]
```
- Add a theme
I named site name `team-Blog`, move into the `team-Blog` folder, then add a hugo theme  
You can choose an existing theme from the website: https://themes.gohugo.io/  
I picked `Soho`  I install it to `team-Blog/theme`
```
$ cd team-BLog/themes
$ git submodule add https://github.com/alexandrevicenzi/soho.git  
```
Back to team-Blog folder, then open config,toml
```
$ cd ..
$ code config.toml
```

add this line at the top
```
theme = "soho"
```
Then add all configuration under it
```
baseURL = "https://example.com"
title = "Soho"
languageCode = "en"
enableInlineShortcodes = true

summarylength = 10
enableEmoji = true

[params]
author = "Author Name"
description = "My Blog"

## Set one of:
# gravatar = "soho@example.com"
profilePicture = "images/profile.png"

copyright = "Author Name"
license = "CC BY-SA 4.0"
licenseURL = "https://creativecommons.org/licenses/by-sa/4.0"

## Set custom theme color.
# themeColor = "#fc2803"

## Set custom CSS and/or JS to override site defaults.
customCss = ["css/blog.css"]
customJs = ["js/blog.js"]

  ## Set as many as you want.
  [[params.socialIcons]]
  icon = "fa-linkedin"
  title = "Linkedin"
  url = "#"

  [[params.socialIcons]]
  icon = "fa-github"
  title = "GitHub"
  url = "#"

  [[params.socialIcons]]
  icon = "fa-twitter"
  title = "Twitter"
  url = "#"

[menu]

  [[menu.main]]
  name = "Posts"
  weight = 100
  identifier = "posts"
  url = "/posts/"

  [[menu.main]]
  name = "About"
  identifier = "about"
  weight = 300
  url = "/about/"

[taxonomies]
  category = "categories"
  series = "series"
  tag = "tags"

[markup]

  [markup.highlight]
  codeFences = true
  guessSyntax = false
  hl_Lines = ""
  lineNoStart = 1
  lineNos = false
  lineNumbersInTable = true
  noClasses = true # if false, you need to provide you own custom CSS
  style = "monokai"
  tabWidth = 4
  ```
  Then, edit information for your site, like I changed   
  `baseURL` = "https://angelo512.github.io/Terabyte-CIT481-Senior-Project/"      
  `title` = "TeraByte"
  `[params] description = "Team Blog"
  ` Github url = "https://github.com/Angelo512/Terabyte-CIT481-Senior-Project"  

- Create new posts
```
$ hugo new post/first-post.md
```
it creates a new post under `team-Blog/content/post/`  
Open the file to write blog
```
$ cd /content/post/
$ code first-post.md
```

You can run local server as run this command at team-Blog directory
```
$ hugo server -D
```
Then, you can see how the blog look like by clicking [localhost:1313]  

After you write blog, build the site by running at team-Blog directory
```
$ hugo -D
```
- Push your code into Github
Now it's time to upload the contents of the /public directory into the Github repo
```
$ cd team-Blog/public
$ git init 
$ git remote add origin https://github.com/Angelo512/Terabyte-CIT481-Senior-Project.git
$ git add .
$ git commit -m "Initial commit"
$ git push --set-upstream origin master
```
Now you go the repo and change the Github page source to `master/root` (if it already set it, just leave it)  
The site's URL should be https://[username].github.io/[reponame], for my case it would be https://angelo512.github.io/Terabyte-CIT481-Senior-Project/



Project 2 Network Diagram
![Project2_vpc w_load balancer diagram](https://user-images.githubusercontent.com/69828773/118353341-a95aa800-b51a-11eb-9b20-29fba2137dd8.png) 

### Domain Setup
- Our domain `terabytecit.com` was transferred from NameCheap.com to AWS
- Create terraform file (terabyteR53.tf) to create a hosted zone and a record to let our domain `terabytecit.com` to point to load balancer DNS address (ie. terabyte-elb-**********.us-west-2.elb.amazonaws.com) 
- Generate TLS certificate in the servers [refer project0 README for instruction](https://github.com/Angelo512/Terabyte-CIT481-Senior-Project/blob/main/Project0/README.md#--generate-tls-certificate) 
