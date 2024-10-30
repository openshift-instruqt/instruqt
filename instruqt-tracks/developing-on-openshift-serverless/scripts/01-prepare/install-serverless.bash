echo "Setting up Serverless..."

# Login as admin
oc login -u admin -p admin

mkdir -p 01-prepare

# Apply the serverless operator
oc create -f https://raw.githubusercontent.com/openshift-instruqt/instruqt/refs/heads/master/instruqt-tracks/developing-on-openshift-serverless/scripts/01-prepare/operator-subscription.yaml
sleep 3

echo "Serverless Operator Subscribed, waiting for deployment..."
# Setup waiting function
curl https://raw.githubusercontent.com/openshift-instruqt/instruqt/refs/heads/master/instruqt-tracks/developing-on-openshift-serverless/scripts/01-prepare/watch-serverless-operator.bash > 01-prepare/watch-serverless-operator.bash
bash 01-prepare/watch-serverless-operator.bash
sleep 3

echo "Serverless Operator deployed. Deploying knative-serving..."
# If we make it this far we have deployed the Serverless Operator!
# Next, Knative Serving
oc create -f https://raw.githubusercontent.com/openshift-instruqt/instruqt/refs/heads/master/instruqt-tracks/developing-on-openshift-serverless/scripts/01-prepare/serving.yaml
sleep 3

echo "Serving created, waiting for deployment..."
# Wait for Serving to install
curl https://raw.githubusercontent.com/openshift-instruqt/instruqt/refs/heads/master/instruqt-tracks/developing-on-openshift-serverless/scripts/01-prepare/watch-knative-serving.bash > 01-prepare/watch-knative-serving.bash
bash 01-prepare/watch-knative-serving.bash
sleep 3

echo "Serving deployed. Setting up developer env..."
# If we make it this far we are GOOD TO GO!
# Login as the developer and create a new project for our tutorial
oc login -u developer -p developer
oc new-project serverless-tutorial

# Done.
sleep 3
#clear
echo "Serverless Tutorial Ready!"
