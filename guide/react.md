# React

### Functiom Component

React.FC is a type alias in React TypeScript definitions that stands for "React Function Component." It is a shorthand way of defining functional components in React with TypeScript.

### Callback

In React, the useCallback hook is used to memoize a callback function. It is useful when you want to prevent unnecessary re-renders of child components that depend on the callback function.

Here's how useCallback works:

    Memoization: When you wrap a function with useCallback, React will memoize the function. Memoization means that React will store the function instance and only recreate it if its dependencies change.

    Dependency Array: The second argument to useCallback is an array of dependencies. These dependencies are used to determine whether the callback function needs to be recreated or not. If any of the dependencies change, the callback function will be re-created.

    Optimization: By memoizing the callback function, React can optimize the rendering process. If a parent component renders and passes the callback function as a prop to multiple child components, those child components can refer to the same function instance instead of each having their own copy. This can prevent unnecessary re-renders of the child components when the parent component updates.


