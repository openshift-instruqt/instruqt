echo "Setting up Serverless..."

# Login as admin
oc login -u admin -p admin

echo "Create an OpenShift Serverless Subscription..."
oc create -f 01-prepare/operator-subscription.yaml
sleep 3

echo "Waiting for completing the OpenShift Serverless Operator..."
bash 01-prepare/watch-serverless-operator.bash
sleep 3

echo "Create a Knative Serving..."
oc create -f 01-prepare/serving.yaml
sleep 3

echo "Waiting for completing the Knative Serving..."
# Wait for Serving to install
bash 01-prepare/watch-knative-serving.bash
sleep 3

echo "Setting up developer env..."
oc login -u developer -p developer
oc new-project serverless-tutorial

sleep 3
echo "Serverless Tutorial Ready!"
