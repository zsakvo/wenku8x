import { Job, Pipeline } from "https://deno.land/x/cicada@v0.1.34/lib.ts";

const job = new Job({
  name: "My First Job",
  image: "ubuntu:22.04",
  steps: [
    {
      name: "Print a message",
      run: "echo Hello, world!",
    },
    {
      name: "Run a js function",
      run: () => {
        console.log("Hello from js");
      },
    },
  ],
});

export default new Pipeline([job]);
