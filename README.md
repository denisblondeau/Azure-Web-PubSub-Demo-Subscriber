# Azure Web PubSub Demo - Subscriber


Swift/SwiftUI MacOS demo of Microsoft's Azure Web Pub Sub service. For more information, see: https://azure.microsoft.com/en-ca/products/web-pubsub/#overview

This is the Subscriber - You also need the Publisher to run this demo: https://github.com/denisblondeau/AzureWebPubSubDemo-Publisher

To get this demo working, before running it, you need to:
- have a Microsoft Azure account.
- create a Web PubSub service within the Azure portal. This one service will handle communications between the Publisher and the Subscriber.
- add your Web PubSub service's hostname and access key to the Subscriber model (SubModel.swift) - this is required to generate the required JSON web token and connect to your Web PubSub host.

Start the Publisher; it will automatically connect to the Web PubSub service's hub (DemoHub). 
Start the subscriber; it will automatically connect to the Web PubSub service's hub (DemoHub) and join the DemoGroup.
In the Publisher, enter some text and send it - it will show up in the Subscriber's window. 

If you cannot get the demo working, check that the Azure Web PubSub server is processing your requests correctly - use the "Live trace settings/Live Trace Tool" in your Web PubSub service's monitoring section to help you debug communication issues between the Publisher and the Subscriber.

Development Environment:
- MacOS Ventura 13.1
- Xcode 14.2

This application requires the installation of the following package to generate JSON web tokens (JWTs): 
- Swift-JWT (https://github.com/Kitura/Swift-JWT)


