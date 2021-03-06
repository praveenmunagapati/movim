<li
    id="{$contact->jid|cleanupId}-chat-item"
    data-jid="{$contact->jid}"
    class="
        {if="$roster && $roster->presence"}
            {if="$roster->presence->value > 4"}faded{/if}
            {if="$roster->presence->last > 60"} inactive{/if}
            {if="$roster->presence->capability && in_array($roster->presence->capability->type, array('handheld', 'phone', 'web'))"}
                action
            {/if}
        {/if}
        "
    title="{$contact->jid}{if="isset($message)"} – {$message->published|strtotime|prepareDate}{/if}">
    {$url = $contact->getPhoto()}
    {if="$url"}
        <span class="primary icon bubble {if="$roster && $roster->presence"}status {$roster->presence->presencekey}{/if}">
            <img src="{$url}">
            <span data-key="chat|{$contact->jid}" class="counter"></span>
        </span>
    {else}
        <span class="primary icon bubble color {$contact->jid|stringToColor} {if="$roster && $roster->presence"}status {$roster->presence->presencekey}{/if}">
            {$contact->truename|firstLetterCapitalize}
            <span data-key="chat|{$contact->jid}" class="counter"></span>
        </span>
    {/if}

    <p class="normal line">
        {if="isset($message)"}
            <span class="info" title="{$message->published|strtotime|prepareDate}">
                {$message->published|strtotime|prepareDate:true,true}
            </span>
        {/if}
        {if="$roster"}
            {$roster->truename}
        {elseif="strpos($contact->jid, '/') != false"}
            {$contact->jid}
        {else}
            {$contact->truename}
        {/if}

        {if="$roster && $roster->presence && $roster->presence->capability"}
            <span class="second" title="{$roster->presence->capability->name}">
                <i class="material-icons">{$roster->presence->capability->getDeviceIcon()}</i>
            </span>
        {/if}
    </p>
    {if="$status"}
        <p class="line">{$status}</p>
    {elseif="isset($message)"}
        {if="$message->isOTR()"}
            <p><i class="material-icons">lock</i> {$c->__('message.encrypted')}</p>
        {elseif="stripTags($message->body) != ''"}
            <p class="line">{$message->body|stripTags|addEmojis}</p>
        {/if}
    {elseif="$roster && $roster->presence && $roster && $roster->presence->status"}
        <p class="line">{$roster->presence->status}</p>
    {/if}
</li>
