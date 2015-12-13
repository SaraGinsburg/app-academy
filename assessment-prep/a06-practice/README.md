# React Assessment

## Instructions

## Setup

If anything here fails, call over a TA to help.

1. `npm install`
2. `bundle install`
3. `rake db:create`
4. `rake db:migrate`
5. `rails server`
6. In a new terminal tab, `webpack --watch`

Test your code live at localhost:3000.

## Running specs

Run specs with `npm test`.

To run the spec file you want, remove the "x" in the "xdescribe" at the top of that file.  For example, in `frontend/__tests__/router-test.js`:

```javascript

xdescribe('router', function () {
    // ...

```
turns into

```javascript

describe('router', function () {
    // ...

```

Then run `npm test`.

We recommend passing your specs in this order:

1. `frontend/__tests__/reactA06-test.js`
2. `frontend/stores/__tests__/postStore-test.js`
3. `frontend/components/__tests__/postIndexItem-test.js`
4. `frontend/components/__tests__/postForm-test.js`
5. `frontend/components/__tests__/postEdit-test.js`
5. `frontend/components/__tests__/postShow-test.js`


## Debugging tips

1. Look at the test file to see how we expect the method to behave.  The errors you see in terminal are not often helpful

2. The bottom most line of the stacktrace gives you the best guess for where your error is.

3. You can add console.logs inside of the test files themselves to poke around if you want.
