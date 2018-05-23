
import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.SortDirection;
import com.google.appengine.api.datastore.FetchOptions;

@SuppressWarnings("serial")
public class FriendsPage extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		
		DatastoreService ds = DatastoreServiceFactory.getDatastoreService();

			Filter propertyFilter =  new Query.FilterPredicate("sender", FilterOperator.NOT_EQUAL, "0");
			Query q = new Query("Tweet").setFilter(propertyFilter);
			q.addSort("sender",SortDirection.ASCENDING);
		
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
					
					if (row[k].contains("sender =")) {
						row[k]=row[k].substring(row[k].indexOf("=")+2, row[k].length());
						result=result + row[k]+"--" ;
					}

					if (row[k].contains("msg =")) {
						row[k]=row[k].substring(row[k].indexOf("=")+2, row[k].length());
						result=result + row[k]+"--" ;
					}
				}
				
				result=result+"---";
			}

			
			req.setAttribute("usertweetsCount", "t Count= " + pq.size());
			req.setAttribute("usertweets", result);

		
		resp.setContentType("text/html");
		RequestDispatcher jsp = req.getRequestDispatcher("/WEB-INF/friendspage.jsp");
		jsp.forward(req, resp);

	}

	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		doGet(req, resp);
	}

}
