# Next.js

## The Command Line Interface

The entrypoint of `next` command is a node script file. In this file, the corresponding command is found according to the arguments. The type of command line is function type. The command is finished by function execution. The `next dev` command will start the server with development server options. There is also a folder named `cli` which is the container of all next commands. The total commands are located in the `lib` directory. The variable `commands` is the mapping type. Its key is the command name and its value is the command function which is loaded from its independent module file. The common commands in the next project is `build`, `dev`, `run`, `lint` and `telemetry`.

### `next build` Command

The build command is defined in the file `cli/next-build.tx`. The main stuff in the build file is file operation and argument handling. After they are done, these paramates are passed to `build` function which does the actual work. The build function is an asynchronous function in the file `build/index.js`. It is the default export of that module file. 
