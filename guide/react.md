# React

### Functiom Component

React.FC is a type alias in React TypeScript definitions that stands for "React Function Component." It is a shorthand way of defining functional components in React with TypeScript.

### Callback

In React, the useCallback hook is used to memoize a callback function. It is useful when you want to prevent unnecessary re-renders of child components that depend on the callback function.

Here's how useCallback works:

    Memoization: When you wrap a function with useCallback, React will memoize the function. Memoization means that React will store the function instance and only recreate it if its dependencies change.

    Dependency Array: The second argument to useCallback is an array of dependencies. These dependencies are used to determine whether the callback function needs to be recreated or not. If any of the dependencies change, the callback function will be re-created.

    Optimization: By memoizing the callback function, React can optimize the rendering process. If a parent component renders and passes the callback function as a prop to multiple child components, those child components can refer to the same function instance instead of each having their own copy. This can prevent unnecessary re-renders of the child components when the parent component updates.

### Dynamic Import

Dynamic imports, introduced in ECMAScript 2018 (ES8), allow you to import modules or scripts dynamically at runtime, rather than at the top-level of your code. It provides a way to conditionally load modules or load them on-demand when they are needed.

### Higher Order Components

React.js Higher-Order Components (HOCs) are a powerful and flexible pattern used for code reuse, logic abstraction, and composition in React applications. HOCs are functions that take a component and return a new enhanced component. They are a way to wrap or decorate a component with additional behavior.

Here's a more detailed explanation of Higher-Order Components in React.js:

1. HOC Definition:
A Higher-Order Component is a function that accepts a component as its input and returns a new component with additional features or behavior. It acts as a wrapper around the original component, adding or modifying functionality.

2. Reusability and Composition:
HOCs promote reusability by encapsulating common functionality that can be shared across multiple components. They allow you to extract logic from components and reuse it in a modular way. HOCs can also be composed together to create more complex behaviors by chaining multiple HOCs.

3. HOC Implementation:
To create an HOC, you define a function that takes a component as a parameter and returns a new component. Within the HOC, you can access and manipulate the props of the wrapped component, modify its behavior, or inject additional props.

4. Props Proxying:
HOCs can intercept and modify the props passed to the wrapped component. They can add new props, modify existing props, or even conditionally render the component based on certain criteria. This allows you to extend the capabilities of the wrapped component without modifying its original implementation.

5. State and Lifecycle Manipulation:
HOCs can manage state and lifecycle methods by wrapping the component in a container component. This enables HOCs to handle common tasks like data fetching, authentication, or event handling. They can also provide additional lifecycle methods or override existing ones to control the behavior of the wrapped component.

6. Caveats and Considerations:
When using HOCs, there are a few things to keep in mind:
- HOCs don't modify the original component; they create a new component.
- HOCs can introduce complexity and make the component hierarchy less transparent.
- Props and state passed to the wrapped component may need to be handled carefully to avoid conflicts or inconsistencies.
- HOCs can cause naming collisions if multiple HOCs are used together. It's important to avoid conflicts in prop names or use techniques like prop name prefixing or composition libraries to mitigate these issues.

7. Examples of HOCs:
Some commonly used HOCs in React.js include:
- Authentication HOC: Adds authentication-related functionality to a component, such as checking if the user is logged in or redirecting to a login page.
- Logging HOC: Logs component lifecycle events or prop changes for debugging purposes.
- Redux HOC: Connects a component to the Redux store, allowing it to access state and dispatch actions.
- Error Handling HOC: Wraps a component with error boundary logic to catch and handle errors gracefully.


