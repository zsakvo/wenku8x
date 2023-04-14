import { Job, Pipeline } from 'https://deno.land/x/cicada@v0.1.34/lib.ts'

const job = new Job({
  name: 'My First Job',
  image: 'ubuntu:22.04',
  steps: [
    {
      name: 'Print a message',
      run: 'echo Hello, world!',
    },
    {
      name: 'Run a js function',
      run: () => {
        console.log('Hello from js')
      },
    },
  ],
})

const jobEnv = new Job({
  name: 'Init Env.',
  image: 'ubuntu:22.04',
  steps: [
    {
      name: 'install snapd',
      run: 'apt update&&apt install snapd -y',
    },
    {
      name: 'install flutter',
      run: 'snap install flutter --classic',
    },
    {
      name: 'print env',
      run: 'flutter sdk-path',
    },
  ],
})

export default new Pipeline([jobEnv])
