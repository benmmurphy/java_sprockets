import org.eclipse.jetty.server.nio.SelectChannelConnector
import org.eclipse.jetty.server.Server
import org.eclipse.jetty.webapp._

object Main extends App {

  val server = new Server()
  val connector = new SelectChannelConnector()
  connector.setPort(4000)
  server.setConnectors(Array(connector))


  val webapp = new WebAppContext()
  webapp.setDescriptor("src/main/webapp/WEB-INF/web.xml")
  webapp.setResourceBase("src/main/webapp")
  webapp.setContextPath("/")
  webapp.setParentLoaderPriority(true)
  webapp.setMaxFormContentSize(600000)
  server.setHandler(webapp)

  server.start()

}
