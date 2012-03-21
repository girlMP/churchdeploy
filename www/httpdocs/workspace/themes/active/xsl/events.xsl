<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



<xsl:template name="component-events">

	<xsl:param name="entries" />
	<xsl:param name="position" />
	<xsl:param name="single" />

	<xsl:if test="count($entries)">

		<div>

			<xsl:call-template name="class-position">
				<xsl:with-param name="component" select="'events'" />
			</xsl:call-template>

			<xsl:choose>

				<xsl:when test="$position = 'column-right'">

					<h3>
						<xsl:call-template name="pluralize">
							<xsl:with-param name="singular" select="'Event'"/>
							<xsl:with-param name="plural" select="'Events'"/>
							<xsl:with-param name="xpath" select="$entries"/>
						</xsl:call-template>
					</h3>

					<ul class="events nav nav-tabs nav-stacked">

						<xsl:call-template name="class-position">
							<xsl:with-param name="component" select="'events'" />
							<xsl:with-param name="classes" select="'events nav nav-tabs nav-stacked'"/>
						</xsl:call-template>

						<xsl:for-each select="$entries">

							<li>

								<xsl:call-template name="class-rows" />

								<a href="#">

									<div class="btn disabled pull-left">

										<div class="month">
											<span class="label label-important">
												<xsl:call-template name="format-date">
													<xsl:with-param name="date" select="date/date/start/@iso" />
													<xsl:with-param name="format" select="'%m-;'" />
												</xsl:call-template>
											</span>
										</div>

										<div class="day">
											<xsl:call-template name="format-date">
												<xsl:with-param name="date" select="date/date/start/@iso" />
												<xsl:with-param name="format" select="'%d;'" />
											</xsl:call-template>
										</div>

									</div>

									<div class="info">

										<h4>
											<xsl:text> </xsl:text>
											<xsl:value-of select="name" disable-output-escaping="yes" />
										</h4>

										<p>

											<xsl:text> &#160;</xsl:text>

											<i class="icon-map-marker"></i>

											<xsl:text> </xsl:text>

											<em>

												<xsl:variable name="location-id" select="location/item/@id" />

												<xsl:for-each select="//events-entries-by-tag-locations/entry[ @id = $location-id ]">

													<xsl:choose>

														<xsl:when test="string-length(name-casual)">
															<xsl:value-of select="name-casual" disable-output-escaping="yes" />
														</xsl:when>

														<xsl:otherwise>
															<xsl:value-of select="name-formal" disable-output-escaping="yes" />
														</xsl:otherwise>

													</xsl:choose>

												</xsl:for-each>

											</em>

										</p>

									</div>

								</a>

							</li>

						</xsl:for-each>

					</ul>

				</xsl:when>

				<xsl:otherwise>

					<xsl:call-template name="cd-pagination">
						<xsl:with-param name="pagination" select="$entries/../pagination" />
						<xsl:with-param name="pagination-url" select="concat( $root, '/', $pt1, '/', $pt2, '/', '$', '/', $pt4, '/', $pt5 )" />
					</xsl:call-template>

					<xsl:for-each select="$entries">

						<xsl:variable name="is-earlier">
						    <xsl:call-template name="date-compare">
						        <xsl:with-param name="first" select="date/date/start"/>
						        <xsl:with-param name="second" select="$today"/>
						    </xsl:call-template>
						</xsl:variable>

						<xsl:variable name="date-format" select="'%d-;, %m+; %d;, %y+;'"/>
						<xsl:variable name="time-format" select="'#h;:#0m; #TS;'"/>

						<xsl:variable name="start-date">
							<xsl:call-template name="format-date">
								<xsl:with-param name="date" select="date/date/start/@iso" />
								<xsl:with-param name="format" select="$date-format" />
							</xsl:call-template>
						</xsl:variable>

						<xsl:variable name="start-time">
							<xsl:call-template name="format-date">
								<xsl:with-param name="date" select="date/date/start/@iso" />
								<xsl:with-param name="format" select="$time-format" />
							</xsl:call-template>
						</xsl:variable>

						<xsl:variable name="end-date">
							<xsl:call-template name="format-date">
								<xsl:with-param name="date" select="date/date/end/@iso" />
								<xsl:with-param name="format" select="$date-format" />
							</xsl:call-template>
						</xsl:variable>

						<xsl:variable name="end-time">
							<xsl:call-template name="format-date">
								<xsl:with-param name="date" select="date/date/end/@iso" />
								<xsl:with-param name="format" select="$time-format" />
							</xsl:call-template>
						</xsl:variable>

						<div>

							<xsl:call-template name="class-rows" />

							<div class="header">

								<h2>
									<xsl:choose>
										<xsl:when test="$single">
											<xsl:value-of select="name" disable-output-escaping="no" />
										</xsl:when>
										<xsl:otherwise>
											<a href="{$root}/20/events/{@id}/{name/@handle}/">
												<xsl:value-of select="name" disable-output-escaping="no" />
											</a>
										</xsl:otherwise>
									</xsl:choose>

									<xsl:if test="$is-earlier &lt; 0">
										<xsl:text> </xsl:text>
										<span class="label label-warning">This occured in the past</span>
									</xsl:if>
								</h2>

								<div class="help-block clearfix">

									<span class="pull-left">

										<xsl:choose>

											<xsl:when test="$start-date = $end-date or not(date/date/end)">
												<span class="date">
													<i class="icon-calendar"></i>
													<xsl:text> </xsl:text>
													<xsl:value-of select="$start-date" />
												</span>
												
												<xsl:text> &#160;</xsl:text>

												<span class="time">
													<i class="icon-time"></i>
													<xsl:text> </xsl:text>
													<xsl:value-of select="$start-time" />

													<xsl:if test="date/date/end/@iso">
														<xsl:text> - </xsl:text>
														<xsl:value-of select="$end-time" />
													</xsl:if>
												</span>
											</xsl:when>
											
											<xsl:otherwise>

												<span class="date-range">

													<i class="icon-calendar"></i>
													<xsl:text> </xsl:text>

													<span class="start">
														<span class="date">		
															<xsl:value-of select="$start-date" />
														</span>
														<xsl:text> </xsl:text>
														<span class="time">
															<xsl:value-of select="$start-time" />
														</span>
													</span>

													<span class="divider">
														<xsl:text> - </xsl:text>
													</span>
													
													<span class="end">
														<span class="date">		
															<xsl:value-of select="$end-date" />
														</span>
														<xsl:text> </xsl:text>
														<span class="time">
															<xsl:value-of select="$end-time" />
														</span>
													</span>

												</span>
											
											</xsl:otherwise>
										
										</xsl:choose>
							
									</span>

									<!-- <span class="pull-right"> -->

										<!-- <span class="location">
											<i class="icon-file"></i>
											<xsl:text> </xsl:text>
											<a href="#">Download Flyer (PDF)</a>
										</span> -->

										<!-- <xsl:text> | </xsl:text> -->

										<!-- <a href="#">Tweet</a>
										<xsl:text>, </xsl:text>
										<a href="#">Facebook</a> -->
									<!-- </span> -->

								</div>

							</div>

							<div class="description">
								
								<xsl:choose>

									<xsl:when test="$single">
										<xsl:value-of select="description" disable-output-escaping="yes" />
									</xsl:when>

									<xsl:otherwise>
										<xsl:variable name="stripped">
										    <xsl:call-template name="remove-html">
										        <xsl:with-param name="text" select="description"/>
										    </xsl:call-template>
										</xsl:variable>
										<xsl:choose>
										    <xsl:when test="string-length($stripped) > 250">
										        <xsl:value-of select="substring($stripped, 0, 250)" disable-output-escaping="yes" />
										        <xsl:text>…</xsl:text>
										    </xsl:when>
										    <xsl:otherwise>
										        <xsl:value-of select="$stripped" disable-output-escaping="yes" />
										    </xsl:otherwise>
										</xsl:choose>										
									</xsl:otherwise>

								</xsl:choose>

							</div>

							<xsl:if test="$single">
								<p><a href="{$current-url}"><i class="icon-lock"></i> Permalink</a></p>
							</xsl:if>

						</div>

					</xsl:for-each>

				</xsl:otherwise>

			</xsl:choose>

			<xsl:call-template name="cd-pagination">
				<xsl:with-param name="pagination" select="$entries/../pagination" />
				<xsl:with-param name="pagination-url" select="concat( $root, '/', $pt1, '/', $pt2, '/', '$', '/', $pt4, '/', $pt5 )" />
			</xsl:call-template>

			<xsl:if test="not($single)">
				<xsl:choose>
					<xsl:when test="$pt2 = 'events' and not($pt5 = 'past')">
						<p><a href="{$root}/{$pt1}/{$pt2}/1/5/past/">« View past events</a></p>
					</xsl:when>
					<xsl:otherwise>
						<p><a href="{$root}/{$pt1}/{$pt2}/">View current events »</a></p>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>

		</div>

	</xsl:if>

</xsl:template>



</xsl:stylesheet>