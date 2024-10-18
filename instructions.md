# All Things Open 2024 take-home challenge

> **_NOTE:_** None of the following commands/actions run against a real AWS Cloud environment. All AWS API requests are directed towards the LocalStack container running on `localhost:4566` on your local machine.

## Scavenger Hunt Instructions:

**Tool Up**: Before diving in, equip yourself with the essentials:

- [The LocalStack CLI](https://docs.localstack.cloud/getting-started/installation/)
- [Docker](https://docs.docker.com/engine/install/)

**Starting LocalStack:** Are you already a LocalStack user? Great! Grab your auth token, and let’s get to work.

`$ export LOCALSTACK_AUTH_TOKEN=<YOUR_AUTH_TOKEN>`

If you're just joining us, let's start by getting you a token. Simply sign up [here](http://app.localstack.cloud). If you're using a personal email provider, you will be able to choose the Hobbyist plan in the next step. If you are using a work email, please select the 14 day trial option. Once in, you'll need a license. Click [here](https://app.localstack.cloud/workspace/auth-token) to go where you need to be directly. Fret not, there is no payment information required. You'll find your Auth Token in the Workspace section in the left-hand panel. Don't forget to export it as an environment variable.

Fire up your engines by running the following command: `localstack start`

In the unlikely situation of something going wrong, follow the instructions in the output logs.

**Inject the Mystery State**: Click [here](https://app.localstack.cloud/launchpad?url=https://raw.githubusercontent.com/localstack-samples/ATO-24-takehome-challenge/main/localstack-cloud-pod) to kickstart your adventure.

Now, the real fun begins!

Navigate to this page to get your first clue: [https://site.s3-website.localhost.localstack.cloud:4566/](https://site.s3-website.localhost.localstack.cloud:4566/)

Follow the instructions on the site to get to the next step. You're heading to a DynamoDB instance and you'll have to do some digging.

**_The Ultimate Invocation_** Did you find the Lambda function? Invoke it by using the new and super easy to use webapp feature.

**The Final Reveal:** Lastly, a new S3 bucket will hold the prize. Go find the new `local-certification` bucket to reedem your new certificate. You're now proficient in using LocalStack.

**Victory Lap:** Congratulations! You've successfully navigated through this grand adventure. What do you think of our tool? Your feedback is the key to our treasure chest of continuous improvement!
**Kick Back and Relax:** No matter how long your resources remain active, rest assured there will be no extra costs. You're completely free from any such concerns!
Now that you've earned your certificate, it's time to flaunt it. Share your triumph with us by sending the proof via the form bellow and you'll be rewarded
