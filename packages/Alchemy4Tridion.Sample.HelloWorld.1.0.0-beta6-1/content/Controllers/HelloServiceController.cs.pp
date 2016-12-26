﻿using Alchemy4Tridion.Plugins;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Tridion.ContentManager.CoreService.Client;

namespace $rootnamespace$.Controllers
{
    /// <summary>
    /// A WebAPI web service controller that can be consumed by your front end.
    /// </summary>
    /// <remarks>
    /// The following conditions apply:
    ///     1.) Must have AlchemyRoutePrefix attribute. You pass in the type of your AlchemyPlugin (the one that inherits AlchemyPluginBase).
    ///     2.) Must inherit AlchemyApiController.
    ///     3.) All Action methods must have an Http Verb attribute on it as well as a RouteAttribute (otherwise it won't generate a js proxy).
    /// </remarks>
    [AlchemyRoutePrefix("HelloService")]
    public class HelloServiceController : AlchemyApiController
    {
        // GET /Alchemy/Plugins/HelloExample/api/HelloService/GetApiVersion
        /// <summary>
        /// Just a simple example showing how we can get the api version using the Core Service Client.
        /// </summary>
        /// <returns>The version number as a string.</returns>
        /// <remarks>
        /// In your resource group class add AddWebApiProxy(); This will allow you to do this in your JS:
        /// Alchemy.Plugins.HelloWorld.Api.Service.getApiVersion()
        /// 
        /// Note that the above namespace is created via:
        /// Alchemy.Plugins.{YourPluginName}.Api.{YourServiceName}.{methodName}
        /// The {YourServiceName} represents the name that you pass into the 2nd argument of the AlchemyRoutePrefixAttribute.
        /// </remarks>
        [HttpGet]
        [Route("ApiVersion")]
        public string GetApiVersion()
        {
            // Use the Client property of AlchemyApiController to access a lazily initialized SessionAwareCoreServiceClient
            // instance. This is actually a special wrapper that is Dispose-safe.  AlchemyApiController will handle
            // the Dispose call of this "Client" property automatically behind the scenes when the request has
            // ended (though there's no harm if you call Client.Dispose() manually either).
            return Client.GetApiVersion();

            // NOTE: The client created is automatically impersonated as the currently logged in Tridion User making
            //       this request!
        }

        /// <summary>
        /// This is an example of using the "User" property of AlchemyApiController (this value can just
        /// as easily have been gotten from the anguilla js framework).
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("IsSystemAdministrator")]
        public string IsUserSystemAdministrator()
        {
            // User is an IUserService, when allows you to easily get the username and UserData of the
            // currently logged in tridion user.  This IUserService instance uses the Client property of
            // this controller for any needed calls via core service.
            return User.GetName() + (User.IsSystemAdministrator() 
                ? " is a System Administrator!"
                : " is NOT a System Administrator!");
        }
        
        /// <summary>
        /// This is an example of a http post method that always throws an exception. When dealing with
        /// http posts, your binding model needs to be the last parameter.  If you have no route parameters,
        /// then it should be your only argument.
        /// </summary>
        /// <param name="someParam"></param>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("ErrorTest/{someParam}")]
        public IHttpActionResult ErrorTest(string someParam, ErrorTestBindingModel model)
        {
            // this will return a error response with a json object like { message: "your custom message" }
            // A normal exception uncaught will just have a generic message like { message: "There was an error." }.
            throw new HttpResponseException(Request.CreateErrorResponse(HttpStatusCode.BadRequest,
                    model.Name + " caused an error!"));
        }

        /// <summary>
        /// Hello world function, returns a message with the name given.
        /// </summary>
        /// <param name="name"></param>
        /// <remarks>
        /// Here the return type is an IHttpActionResult.  We can return our value or view model
        /// using the generic 'return Ok()' method.  We can return a BadRequest to have a bad request
        /// http code in the response.
        /// </remarks>
        [HttpGet]
        [Route("Hello/World/{name}")]
        public IHttpActionResult HelloWorld(string name)
        {
            if (String.IsNullOrEmpty(name))
            {
                // this will return a error response with a json object like { message: "your message" }
                // see ErrorTest() for example of how exceptions can contain messages
                return BadRequest("'name' is required for HelloWorld action.");
            }

            return Ok(String.Format("Hello {0}!!!", name));
        }
    }
}
