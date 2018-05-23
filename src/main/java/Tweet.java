

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.FetchOptions;


@SuppressWarnings("serial")
public class Tweet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		
		String sndName="";
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();
		
		if (req.getParameterMap().containsKey("sndName")) {		
			sndName=req.getParameter("sndName");
			req.setAttribute("testsndName", sndName);
		}
		
	if (req.getParameterMap().containsKey("my_text")) {		
		String msg = (String) req.getParameter( "my_text" );
		sndName = (String) req.getParameter( "sndName" );
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		
		Entity tweet = new Entity("Tweet", uuid);
		tweet.setProperty("sender", sndName);
		tweet.setProperty("msg", msg);
		tweet.setProperty("visited", 0);
		tweet.setProperty("msgDate", new Date());
		ds.put(tweet);
	}

	if (!sndName.equals("")){
			Filter propertyFilter =  new Query.FilterPredicate("sender", FilterOperator.EQUAL, sndName);
			Query q = new Query("Tweet").setFilter(propertyFilter);
			//q.addSort("msgDate",SortDirection.ASCENDING);
		
			List<Entity> pq = ds.prepare(q).asList(FetchOptions.Builder.withDefaults());
			String result="";
			for (int i = 0; i < pq.size(); i++) {
				String row[]= pq.get(i).toString().split(System.lineSeparator());
				for (int k = 0; k < row.length; k++) {
					if (row[k].contains("[Tweet(")) {
						row[k] = row[k].substring(row[k].toString().indexOf("\"")+1, row[k].length());
						row[k] = row[k].substring(0, row[k].indexOf("\""));
						result=result + row[k]+"--" ;
					}
					if (row[k].contains("msg =")) {
						row[k]=row[k].substring(row[k].indexOf("=")+2, row[k].length());
						result=result + row[k]+"--" ;
					}
				}
				
				result=result+"---";
			}

			
			//req.setAttribute("usertweetsCount", "t Count= " + pq.size());
			req.setAttribute("usertweets", result);
		}	
		resp.setContentType("text/html");
        RequestDispatcher jsp = req.getRequestDispatcher("/WEB-INF/tweet.jsp");
        jsp.forward(req, resp);
	}
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		doGet(req,resp);
	}
}