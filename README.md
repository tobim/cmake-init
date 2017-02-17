# cmake-init
a cmake project generator written in cmake

quick usage:
```
cmake -B<project-name> -H<path-to-cmake-init>/header-only-library
cd <project-name>
./FINALIZE.sh
```

advanced usage:
```
ccmake -B<project-name> -H<path-to-cmake-init>/header-only-library
# -> press 'c' to configure
# -> edit the available variables to match your equirements
# -> press 'c' to update the configuration
# -> press 'g' to generate the project
cd <project-name>
./FINALIZE.sh
```
