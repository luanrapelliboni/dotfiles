#!/usr/bin/env perl
open( CF, '>',"$ENV{HOME}/.aws/credentials");
print CF <<EOF;
[default]
aws_session_token=$ENV{AWS_SESSION_TOKEN}
aws_secret_access_key=$ENV{AWS_SECRET_ACCESS_KEY}
aws_access_key_id=$ENV{AWS_ACCESS_KEY_ID}
EOF

system "export AWS_SESSION_TOKEN=$ENV{AWS_SESSION_TOKEN}";
system "export AWS_SECRET_ACCESS_KEY=$ENV{AWS_SECRET_ACCESS_KEY}";
system "export AWS_ACCESS_KEY_ID=$ENV{AWS_ACCESS_KEY_ID}";
system "export AWS_DEFAULT_REGION=$ENV{AWS_REGION}";
system "export AWS_REGION=$ENV{AWS_REGION}";
system "aws configure set default.region $ENV{AWS_REGION}";
