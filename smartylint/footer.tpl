    </main>

    <footer class="site-footer">
        {* *}

        {if true}
            <div class="footer-links">
                <a href="/about">About</a>
                <a href="/help">Help</a>
                <a href="/privacy">Privacy</a>
            </div>
        {/if}

        {if $show_newsletter}
        {/if}

        {foreach $social_links as $link}
        {/foreach}

        <div class="copyright">
            <p>&copy; {$current_year} Demoapp.</p>
            <p>Build {$build_id|@default:"dev"}</p>
        </div>

        {if $debug == "true"}
            <pre class="debug">
                {$debug_payload}
            </pre>
        {/if}
    </footer>

    {include file=tracking.tpl}
    {include file="scripts.tpl"}
</body>
</html>
